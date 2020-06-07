import { Component, OnInit, AfterViewInit, ElementRef, ViewChild } from '@angular/core';
import * as Story from './story.json';

@Component({
  selector: 'app-georgefloyd',
  templateUrl: './georgefloyd.component.html',
  styleUrls: ['./georgefloyd.component.css']
})
export class GeorgefloydComponent implements OnInit, AfterViewInit
{

  @ViewChild('ticker', {read: ElementRef, static:false}) tickerElementView: ElementRef;
  @ViewChild('maindisplay', {read: ElementRef, static:false}) mainDisplayElementView: ElementRef;
  @ViewChild('seconddisplay', {read: ElementRef, static:false}) secondDisplayElementView: ElementRef;
  private ticker: any = null;
  private mainDisplay: any = null;
  private secondDisplay: any = null;
  private duration: number = 0;
  private remainingDuration: number = 0;
  private message: string = "";
  private start: number = null;
  private running: boolean = false;
  private renderer: any = null;
  private story: string[] = [];

  constructor() { }

  ngOnInit(): void { }

  ngAfterViewInit(): void
  {
    const duration_in_milliseconds: number = 526000; // = 8.46 minutes
    const end_message = "R.I.P";
    const story = Story["default"];
    this.init(duration_in_milliseconds, end_message, story);
    this.start_countdown();
    this.start_story();
  }

  private init(duration_in_milliseconds: number, end_message: string, story: string[]): void
  {
    this.ticker = this.tickerElementView.nativeElement;
    this.mainDisplay = this.mainDisplayElementView.nativeElement;
    this.secondDisplay = this.secondDisplayElementView.nativeElement;
    this.duration = duration_in_milliseconds;
    this.message = end_message;
    this.story = story;
    this.running = false;
  }

  private start_story(): void
  {
    const interval = this.duration / this.story.length;
    let storyPart = 0;

    const plot = () =>
    {
      if (storyPart === this.story.length)
      {
        clearInterval(storyTeller);
        return;
      }
      this.secondDisplay.textContent = this.story[storyPart];
      storyPart++;
    }

    const storyTeller = setInterval(plot, interval);
  }

  private start_countdown(): void
  {
    this.start = null;
    this.running = true;
    this.remainingDuration = this.duration;
    this.mainDisplay.textContent = this.msToTime(this.duration);
    this.renderer = requestAnimationFrame(this.render.bind(this));
  }

  private stop_countdown(): void
  {
    this.running = false;
    if (this.renderer)
    {
      cancelAnimationFrame(this.renderer);
    }
    this.mainDisplay.textContent = this.message;
  }

  private render(now: number): void
  {
    if (!this.start)
    {
      this.start = now;
    }
    const diff = now - this.start;
    const newDuration = Math.ceil((this.duration - diff));

    if (diff <= this.duration)
    {
			this.ticker.style.height = 100 - (diff/this.duration*100) + '%';

      if (newDuration != this.remainingDuration)
      {
        this.mainDisplay.textContent = this.msToTime(newDuration);
				this.remainingDuration = newDuration;
      }

			this.renderer = requestAnimationFrame(this.render.bind(this));
    }
    else
    {
      this.ticker.style.height = '0%';
      this.stop_countdown();
    }
  }

  private msToTime(duration_in_milliseconds: number): string
  {
    const seconds = Math.floor((duration_in_milliseconds / 1000) % 60),
    minutes = Math.floor((duration_in_milliseconds / (1000 * 60)) % 60),
    hours = Math.floor((duration_in_milliseconds / (1000 * 60 * 60)) % 24);

    const enc_hours = (hours < 10) ? "0" + hours : hours;
    const enc_minutes = (minutes < 10) ? "0" + minutes : minutes;
    const enc_seconds = (seconds < 10) ? "0" + seconds : seconds;

    return enc_hours + ":" + enc_minutes + ":" + enc_seconds;
  }

}
